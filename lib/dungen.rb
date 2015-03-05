class Dungen
  WALL = "#"
  SPACE = " "
  OFFSETS = [1,0,-1]

  def layer(width, height)
    Array.new(height) { Array.new(width) { WALL } }
  end

  def room(width, height)
    Array.new(height) { Array.new(width) { SPACE } }
  end

  def rooms(count)
    (1..count).map { room(8, 4) }
  end

  def carve(room, layer)
    l_width = layer.first.length
    l_height = layer.length
    r_width = room.first.length
    r_height = room.length
    top_left = [rand(l_width - r_width), rand(l_height - r_height)]
    r_height.times do |r|
      row = r + top_left[1]
      r_width.times do |c|
        col = c + top_left[0]
        layer[row][col] = SPACE
      end
    end
    layer
  end

  def carve_space(row,col,layer)
    begin
      layer[row][col] = SPACE
    rescue NoMethodError
      raise "oops tried to carve into #{row},#{col}; row was: #{layer[row].inspect}"
    end
  end

  def format(layer)
    layer.map(&:join).join("\n")
  end

  def carve_path(length, layer)
    row = (4..(layer.length - 4)).to_a.sample
    col = (4..(layer.first.length - 4)).to_a.sample
    length.times do
      carve_space(row,col,layer)
      row, col = move_cursor(row,col,layer)
      puts "just carved a space from layer, now it's:"
      puts format(layer)
      sleep(0.01)
    end
  end

  def linear_move_cursor(index,dim_length)
    if (3...dim_length).include?(index) # -- in the middle, can go anywhere
      index + OFFSETS.sample
    elsif index < 1 #at the top or left, move toward center
      index + 1
    else #near the bottom or right, move toward center
      index - 1
    end
  end

  def move_cursor(row,col,layer)
    new_ones = [linear_move_cursor(row,layer.length - 5), linear_move_cursor(col,layer.first.length - 5)]
    #puts "moved from cursor position [#{row},#{col}] to [#{new_ones[0]},#{new_ones[1]}]"
    new_ones
  end

  def out_of_bounds?(row, col, layer)
    (row >= layer.length - 1) || col >= (layer.first.length - 1)
  end
end

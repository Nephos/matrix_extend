# TODO : use StaticArray with Pointers
class MatrixExtend::Matrix(T)
  property data : Array(Array(T))
  property lines : Int32
  property columns : Int32

  def initialize(@lines, @columns)
    @data = Array(Array(T)).new(@lines) { Array(T).new(@columns) { T.new(yield) } }
  end

  def initialize(@lines, @columns, default : T = T.new(0))
    @data = Array(Array(T)).new(@lines) { Array(T).new(@columns) { T.new(default) } }
  end

  def initialize(@lines, @columns, @data)
  end

  def self.from(data : Array(Array(T))) : self
    self.new(data.size, data.first.size, data)
  end

  def to_s
    "Matrix(#{to_a})"
  end

  def self.identity(lines, columns) : self
    self.new(lines, columns).tap do |m|
      lines.times do |l|
        columns.times do |c|
          m[l, c] = T.new(1) if l == c
        end
      end
    end
  end

  def clone
    typeof(self).new(@lines, @columns).tap do |m|
      self.data.each_with_index do |line, y|
        line.each_with_index { |cell, x| m[y][x] = cell }
      end
    end
  end

  def +(right : typeof(self)) : typeof(self)
    clone.tap do |m|
      right.data.each_with_index do |line, y|
        line.each_with_index { |cell, x| m[y][x] += cell }
      end
    end
  end

  def *(right : Matrix(T)) : typeof(self)
    raise "cannot muliply M1 * M2 if M1.columns != M2.lines (#{self.columns} != #{right.lines})" if self.columns != right.lines
    Matrix(T).new(self.lines, right.columns).tap do |m|
      m.lines.times do |y|
        m.columns.times do |x|
          m[y][x] = self.each_line[y].zip(right.each_column[x]).map {|l, c| l * c}.sum
        end
      end
    end
  end

  def *(right : Number::Primitive) : typeof(self)
    clone.tap {|m| m.flatten_map! { |cell| cell * right } }
  end

  def flatten : Array(T)
    @data.flatten
  end

  def flatten_map! : typeof(self)
    y = 0
    @data.map! { |line| x = 0; line.map { |cell| yield cell, y, x } }
    self
  end

  def transpose : typeof(self)
    #typeof(self).new(@columns, @lines).tap do |m|
    clone.tap do |m|
      m.data = m.data.transpose
      m.lines, m.columns = m.columns, m.lines
    end
  end

  def t
    transpose
  end

  def to_a : Array(Array(T))
    @data.to_a
  end

  def each_line(&b)
    @data.each { |l| yield l }
    self
  end

  def each_line : Array(Array(T))
    @data.to_a
  end

  def each_column(&b)
    @data.transpose.each { |c| yield c }
    self
  end

  def each_column : Array(Array(T))
    @data.transpose.to_a
  end

  def set_line(idx : Int32, v : Array(T))
    raise "Invalid number of columns passed (#{@columns}, given #{v.size})" if v.size != @columns
    @data[idx] = v
    self
  end

  def set_column(idx : Int32, v : Array(T))
    raise "Invalid number of lines passed (#{@lines}, given #{v.size})" if v.size != @lines
    @data.each_with_index { |_, y| @data[y][idx] = v[y] }
    self
  end

  def [](y : Int32)
    @data[y]
  end

  def [](y : Int32, x : Int32)
    @data[y][x]
  end

  def []=(y : Int32, v : Array(T))
    @data[y] = v
  end

  def []=(y : Int32, x : Int32, v : T)
    @data[y][x] = v
  end
end

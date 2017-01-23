describe Matrix do
  it "instance" do
    m = Matrix(Float64).new 2, 3
    m.lines.should eq 2
    m.columns.should eq 3
  end

  it "equal" do
    m1 = Matrix(Int32).from [[1, 2], [2, 3]]
    m2 = Matrix(Int32).from [[1, 2], [2, 3]]
    m3 = Matrix(Int32).from [[1, 2], [2, 1]]
    (m1 == m2).should be_true
    (m1 == m3).should be_false
  end

  it "identity" do
    m = Matrix(Float64).identity 2, 3
    m.lines.should eq 2
    m.columns.should eq 3
    m[0, 0].should eq 1
    m[1, 1].should eq 1
    m[0, 1].should eq 0
    m[1, 0].should eq 0
  end

  it "transpose" do
    m1 = Matrix(Float64).new(2, 3)
    m1.set_line 0, [1.0, 2.0, 3.0]
    m1.set_line 1, [3.0, 5.0, 6.0]
    m2 = m1.transpose
    m2.lines.should eq 3
    m2.columns.should eq 2
    m2[0, 0].should eq 1
    m2[1, 0].should eq 2 # <= 3
    m2[0, 1].should eq 3 # <= 2
    m2[1, 1].should eq 5
  end

  it "set_" do
    m = Matrix(Float64).identity 2, 2
    m.set_line 0, [1.0, 2.0]
    m[0, 0].should eq 1
    m.set_column 0, [2.0, 2.0]
    m[1, 0].should eq 2
    expect_raises { m.set_line 0, [1.0] }
  end

  it "addition" do
    m1 = Matrix(Float64).identity 2, 3
    m2 = Matrix(Float64).identity 2, 3
    m3 = m1 + m2
    m3[0, 0].should eq 2
    m3[1, 1].should eq 2
    m3[0, 1].should eq 0
    m3[1, 0].should eq 0
  end

  it "multiplication" do
    m1 = Matrix(Float64).new 2, 3
    m2 = Matrix(Float64).new 3, 1
    m1[0] = [1.0, 2.0, 3.0]
    m1[1] = [4.0, 5.0, 6.0]
    m2[0, 0] = 7.0
    m2[1, 0] = 8.0
    m2[2, 0] = 9.0
    m3 = m1 * m2
    m3.lines.should eq 2
    m3.columns.should eq 1
    m3[0, 0].should eq 50
    m3[1, 0].should eq 122
    #
    m1 = Matrix(Float64).new 2, 2
    m2 = Matrix(Float64).new 2, 2
    m1[0] = [1.0, 2.0]
    m1[1] = [3.0, 4.0]
    m2[0] = [5.0, 6.0]
    m2[1] = [7.0, 8.0]
    m3 = m1 * m2
    m3.lines.should eq 2
    m3.columns.should eq 2
    m3[0, 0].should eq 19
    m3[0, 1].should eq 22
    m3[1, 0].should eq 43
    m3[1, 1].should eq 50
  end

  it "each_line" do
    m = Matrix(Float64).identity 2, 3
    i = 0
    m.each_line { |l| l.size.should eq 3; i += 1 }
    i.should eq 2
  end

  it "each_column" do
    m = Matrix(Float64).identity 2, 3
    i = 0
    m.each_column { |l| l.size.should eq 2; i += 1 }
    i.should eq 3
  end

  it "flatten" do
    m = Matrix(Float64).new 2, 2, [[1.0, 2.0], [3.0, 4.0]]
    m.flatten.should eq [1.0, 2.0, 3.0, 4.0]
  end

  it "flatten_map" do
    m = Matrix(Float64).new 2, 2, [[1.0, 2.0], [3.0, 4.0]]
    m.flatten_map! { |e| e * 2.0 }.flatten.should eq [2.0, 4.0, 6.0, 8.0]
    m.flatten.should eq [2.0, 4.0, 6.0, 8.0]
  end
end

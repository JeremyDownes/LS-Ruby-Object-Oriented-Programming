module Paint
  def spray_paint(color)
    self.color = color
  end
end

module Towable
  def towing?
    puts "You are hauling #{@weight}" 
  end
  def haul(weight)
    @weight = weight
  end
end

class Vehicle
  @@vehicles = []
  include Paint
  
  def init(vehicle)
    @@vehicles.push(vehicle)
  end
  
  def self.count
    print @@vehicles.length
  end
  
  def ignition(switch2)
    if switch2 == "on"
      self.is_on = true
      puts "Your vehicle is running"
    end
    if switch2 == "off"
      if speed > 0
        puts "You have to slow down first"
      else 
        self.is_on = false
        puts "Your ignition is off"
      end
    end
  end
 
  def accelerate(increase)
    if speed+increase > 130; puts "You're at top speed"
    else self.speed += increase
    end
  end    
  def decelerate(decrease)
    if speed-decrease <= 0; puts "You're stopped"; self.speed = 0
    else self.speed -= decrease
    end
  end
  def status
    if is_on
      if speed > 0
        puts "You are driving in your #{color} #{make} #{model} at #{speed} MPH!"
      else puts "You are idling in your #{make} #{model}"
      end
    end
  end
  def calculate_gas_milage(miles,gallons)
    miles / gallons
  end
  def efficiency
    ((speed * 0.0166) * @MPG).round
  end  
  def to_s
    if self.speed == 0
        puts "You are sitting in your #{color} #{year} #{make} #{model}"
    else 
        puts "You are driving in your #{color} #{year} #{make} #{model} at #{speed} MPH and getting #{efficiency} miles per gallon"
    end
  end
  def age
    a_lady_never_tells
  end
  private
  def a_lady_never_tells
    Time.now.year - @year
  end
end

class Car < Vehicle
  SPORTSUSPENSION = true
  @@cars = []
  attr_reader :year, :make, :model, :MPG
  attr_accessor :color, :speed, :is_on
  def initialize(year,make,model,color,range,tank,speed=0,is_on=false)
    @year = year
    @make = make
    @model = model
    @color = color
    @speed = speed
    @MPG   = calculate_gas_milage(range,tank)
    @is_on = is_on
    @@cars.push(self)
    init(self)
  end
end

class Truck < Vehicle
  include Towable
  TOWINGSUSPENSION = true
  @@trucks = []
  attr_reader :year, :make, :model, :MPG
  attr_accessor :color, :speed, :is_on
  def initialize(year,make,model,color,range,tank,speed=0,is_on=false)
    @year = year
    @make = make
    @model = model
    @color = color
    @speed = speed
    @MPG   = calculate_gas_milage(range,tank)
    @is_on = is_on
    @@trucks.push(self)
    init(self)
  end
end

vehicles = []
loop do
  print "Enter NEW car information or QUIT"
  init = gets.chomp.downcase
  break if init == "quit" || init == "q"
  if init == "new"
    print "Year?"
    year = gets.chomp.to_i
    print "Make?"
    make = gets.chomp
    print "Model?"
    model = gets.chomp
    print "Color?"
    color = gets.chomp
    print "Range in miles?"
    range = gets.chomp.to_i
    print "Fuel capacity in gallons?"
    tank = gets.chomp.to_i
    print "Truck or car?"
    c_or_t = gets.chomp[0].downcase
    if c_or_t == "c"; my_v = Car.new(year,make,model,color,range,tank) end
    if c_or_t == "t"; my_v = Truck.new(year,make,model,color,range,tank) end
    vehicles.push(my_v)
  end
end
in_v = false
loop do
  while !in_v
    puts "Choose a vehicle"
    vehicles.each { |v_x|  puts v_x.model }
    vehicle = gets.chomp
    vehicles.each {|v_x| if v_x.model == vehicle
                        vehicle = v_x
                        in_v = true
                        end}
  end
  puts "Actions can be : START, STOP, GAS, BRAKE, LEFT, RIGHT, PAINT, and EXIT"
  while in_v
    print "Action ?"
    actn = gets.chomp.downcase
    case actn
      when "gas" 
        if vehicle.is_on 
          print "How much?"
          vehicle.accelerate(gets.chomp.to_i)
        else puts "You have to start it first." end
      when "brake"
        if vehicle.is_on
          print "How much?"
          vehicle.decelerate(gets.chomp.to_i)
        else puts "You're not moving." end
      when "start"; vehicle.ignition("on")
      when "stop"; vehicle.ignition("off")
      when "left"; puts "You turn left"
      when "right"; puts "You turn right"
      when "exit"; if vehicle.is_on 
                     puts "Stop your engine first"
                     else in_v = false end
      when "paint"; if vehicle.is_on 
                     puts "Stop your engine first"
                     else 
                       print "What color?"
                       vehicle.spray_paint(gets.chomp) end
      when "year"
        puts vehicle.year
      when "info"
        puts vehicle
      when "towing?"
        if vehicle.is_a? Truck; vehicle.towing? end
      when "haul"
        if vehicle.is_a? Truck
          print "Payload?"
          weight = gets.chomp
          vehicle.haul(weight)
        end
      when "class"
        p Car.ancestors
        p Truck.ancestors
      when "age"; p vehicle.age
      end
    vehicle.status
end
  print "Continue ?"
  break unless gets.chomp.downcase == "y"
end

class Student
  attr_accessor :name
  def initialize(name,grade)
    @name = name
    @grade = grade
  end
  def better_grade_than?(peer)
    if @grade > peer.grade; return true end
  end
  protected
  def grade
    @grade
  end
end
"The Person object's hi method is private and inaccessible. Define a method in the object to access the private method"
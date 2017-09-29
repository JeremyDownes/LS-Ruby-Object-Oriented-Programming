module Paint
  def spray_paint(color)
    self.color = color
  end
end

class Car
  @@cars = []
  attr_reader :year, :make, :model, :MPG
  attr_accessor :color, :speed, :is_on
  include Paint
  def initialize(year,make,model,color,range,tank,speed=0,is_on=false)
    @year = year
    @make = make
    @model = model
    @color = color
    @speed = speed
    @MPG   = calculate_gas_milage(range,tank)
    @is_on = is_on
    @@cars.push(self)
  end
  def ignition(switch2)
    if switch2 == "on"
      self.is_on = true
      puts "Your car is running"
    end
    if switch2 == "off"
      if speed > 0
        puts "You have to slow down first"
      else 
        self.is_on = false
        puts "Your car is off"
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
end

cars =[]
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
    new_car = Car.new(year,make,model,color,range,tank)
    cars.push(new_car)
  end
end
car = {}
in_car = false
loop do
  while !in_car
    puts "Choose a car"
    cars.each { |car_x|  puts car_x.model }
    car = gets.chomp
    cars.each {|car_x| if car_x.model == car
                        car = car_x
                        in_car = true
                        end}
  end
  puts "Actions can be : START, STOP, GAS, BRAKE, LEFT, RIGHT, PAINT, and EXIT"
  while in_car
    print "Action ?"
    actn = gets.chomp.downcase
    case actn
      when "gas" 
        if car.is_on 
          print "How much?"
          car.accelerate(gets.chomp.to_i)
        else puts "You have to start it first." end
      when "brake"
        if car.is_on
          print "How much?"
          car.decelerate(gets.chomp.to_i)
        else puts "You're not moving." end
      when "start"; car.ignition("on")
      when "stop"; car.ignition("off")
      when "left"; puts "You turn left"
      when "right"; puts "You turn right"
      when "exit"; if car.is_on 
                     puts "Stop your engine first"
                     else in_car = false end
      when "paint"; if car.is_on 
                     puts "Stop your engine first"
                     else 
                       print "What color?"
                       car.spray_paint(gets.chomp) end
      when "year"
        puts car.year
      when "info"
        puts car
      end
    car.status
end
  print "Continue ?"
  break unless gets.chomp.downcase == "y"
end
"There is no method set for changing the state of 'name' in person. Change attr_reader to attr_accessor."

class Car
    def initialize(year,make,model,color,speed=0,is_on=false)
        @year = year
        @make = make
        @model = model
        @color = color
        @speed = speed
        @is_on = is_on
    end
    def is_on
        @is_on
    end
    def desc
        @model
    end
    def ignition(switch)
        if switch == "on"
            @is_on = true
            puts "Your car is running"
        end
        if switch == "off"
           if @speed > 0
                puts "You have to slow down first"
            else 
                @is_on = false
                puts "Your car is off"
            end
        end
    end
 
    def accelerate(increase)
        if @speed+increase > 130; puts "You're at top speed"
        else @speed += increase
        end
    end    
    def decelerate(decrease)
        if @speed-decrease < 0; puts "You're stopped"; @speed =0
        else @speed -= decrease
        end
    end
    def status
        if self.is_on
            if @speed > 0
                puts "You are driving in your #{@make} #{@model} at #{@speed} MPH!"
            else puts "You are parked in your #{@make} #{@model}"
            end
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
        new_car = Car.new(year,make,model,color)
        cars.push(new_car)
    end
end
car = {}
in_car = false
loop do
while !in_car
    puts "Choose a car"
    cars.each { |car_x|  puts car_x.desc }
    car = gets.chomp
    cars.each {|car_x| if car_x.desc == car
                        car = car_x
                        in_car = true
                        end}
end
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
    end
    car.status
end
  print "Continue ?"
  break unless gets.chomp.downcase == "y"
end
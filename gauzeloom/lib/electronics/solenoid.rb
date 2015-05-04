class Solenoid < CrystalScad::Assembly
	
	skip :output
	view [:base, :shaft, :frame]

	def initialize(args={})
		@y = 20
		@base_height = 44

		@pos = args[:pos] || 0

		if @pos > 19
			@pos = 19		
		end
	end

	def part(show)
		res = frame			
		res += base.rotate(y:90).translate(x:-@base_height,y:@y/2.0,z:23.0/2)		
		res += shaft.rotate(y:90).translate(x:-25-@pos,y:@y/2.0,z:23.0/2)		
	
	end

	def base
		# cylinder with the windings inside
		res = cylinder(d:19.5,h:@base_height)
		# flange of the cylinder
		res += cylinder(d:13.95,h:53.6)	
		res.color("Silver")
	end

	def shaft
		res = cylinder(d:9.25,h:h=65+8+12)
		res -= cylinder(d:3.1,h:20).translate(z:-10).rotate(y:90).translate(z:h-2.5)
		res = res.color("DarkGray")

		bolt = Bolt.new(3,16).mirror(z:1).translate(z:11.5).rotate(y:90).translate(z:h-2.5)
		res += bolt.show
	end
		
	def frame
		# omitting the corners being angled
		res = cube([x=86,@y,1.5])
		res += cube([1.5,@y,23]) 

		res -= long_slot(d:5.6,h:5,l:11).translate(x:14,y:@y/2.0,z:-1)
		res -= cylinder(d:7,h:5).translate(x:25,y:@y/2.0,z:-1)

		res -= long_slot(d:4.9,h:5,l:22).translate(x:35,y:@y/2.0,z:-1)

		res -= cylinder(d:3.2,h:5).translate(x:x-3.5,y:y/2.0,z:-1)
	
		res.color("Gainsboro")
	end

end
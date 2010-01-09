@array = Array.new(100) do |x|
	Array.new(100) do |y|
		numero = rand(400)
		if numero < 10
			numero = "00" + numero.to_s + " "
		elsif numero < 100
			numero = "0" + numero.to_s + " "
		else
			numero = numero.to_s + " "	
		end
	end # y
end # x
f = File.new("map.txt", 'w+')
@array.each { |line| f.write(line.to_s+"\n") }
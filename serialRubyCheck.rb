
#This code sends a "b" over Serial every 4 seconds
#That means that the LED connected to the Arduino
#will blink every four seconds.
 
require 'serialport'
 
#this *will* be different for you
#You need to find out what port your arduino is on
#and also what the corresponding file is on /dev
#You can do this by looking at the bottom right of the Arduino
#environment which tells you what the path.
 
#this must be same as the baud rate set on the Arduino
#with Serial.begin
baud_rate = 9600
port_file = "/dev/ttyUSB0" 
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE
 
#create a SerialPort object using each of the bits of information
port = SerialPort.new(port_file, baud_rate, data_bits, stop_bits, parity)
 
wait_time = 1
 
#for an infinite amount of time
loop do 
 
	 #wait a little bit before we send the next one
	 sleep wait_time

	while (i = port.gets) do
	  puts i
	end

end
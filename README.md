# Verilog-Implementation-of-UART-SPI-I2C-Protocols

1) SPI:-  
The Serial Peripheral Interface (SPI) is a synchronous communication protocol used for short-distance data exchange between a master and one or more slaves. In this design, the master initiates communication using a start signal and sends a 12-bit input din to the slave through the mosi line. The SPI master operates with three main output signals: cs (chip select), mosi (master out, slave in), and sclk (serial clock). When start is asserted, the cs line goes low, enabling the slave, and the 12-bit data is transmitted serially on each rising edge of sclk. Tsclk=20*Tclk, ensuring slower bitwise transmission. After all bits are sent, cs is set high, and a done signal is raised to indicate completion. The system returns to the idle state, ready for the next transaction. This design allows simple verification of serial transmission by comparing the sent din data with the received serial data on mosi.

![image](https://github.com/user-attachments/assets/b62a7dd3-d090-4053-ba8b-8124a66a3335)

2) UART:-
This design implements a UART-like communication protocol for serial data transmission and reception. It supports 8-bit data transfer, framed with 1 start bit and 1 stop bit, totaling 10 bits. The transmitter sends data on the tx line when start is high, embedding txin between the start and stop bits. The bit duration is controlled by the baud rate, derived from the input clk and a specified wait_count. The transmitter shifts each bit at intervals defined by bitDone, and signals txdone when the transmission completes. The receiver monitors the rx line and detects the start bit, then samples incoming bits at mid-bit intervals to ensure timing accuracy. It reconstructs the received word in rxout and raises rxdone when reception is complete. The design includes separate state machines for TX and RX, ensuring reliable asynchronous serial communication.

![image](https://github.com/user-attachments/assets/3be8ee21-7e3c-47e6-87e2-f58b63da8f26)

3) I2C:-
   The I²C EEPROM module facilitates serial communication between a master and a memory device using the I²C protocol. It operates over two bidirectional lines: SCL (serial clock) and SDA (serial data). The design supports both read and write operations based on the wr input and uses a 7-bit slave address followed by a read/write bit. Communication is initiated when newd is high, triggering a START condition, followed by address and data transfer, with acknowledgments (ack) expected at key stages. The module uses a state machine to handle address transmission, data writing (wdata), and data reception (rdata). The output sda is controlled through tri-state logic, enabling bidirectional data flow. A slower clock (sclk_ref) derived from clk regulates the timing of the I²C bus, ensuring proper synchronization. The done signal is asserted high once the complete read or write transaction is finished, allowing external logic to monitor operation completion.

   ![image](https://github.com/user-attachments/assets/daf0ba25-a116-4e19-8f7f-45fe589145dd)




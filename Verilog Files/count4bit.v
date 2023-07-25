

module gpio_control(
  input clk, // clock input
  input btn, // button input
  output wire [1:0] gpio // 2-bit GPIO output
);

  reg [1:0] gpio_out; // internal register to store GPIO output
  reg [31:0] counter; // internal counter to track time
  
  // On each clock cycle, check the state of the button and update the GPIO output
  always @(posedge clk) begin
    if (!btn) begin // button pressed
      counter <= 600000000; // set counter 
      gpio_out <= 2'b00; // set first two GPIO pins low
    end
    else if (counter > 0) begin // counter is running
      counter <= counter - 1; // decrement counter
      if (counter == 420000000) gpio_out <= 2'b01; // 
      else if (counter == 180000000) gpio_out <= 2'b10; // 
    end
    else if (counter == 0) begin // counter has reached zero
      counter <= 600000000; // reset counter 
    end
    else gpio_out <= 2'b00; // set all GPIO pins low
  end

  assign gpio = gpio_out; // assign GPIO output to the internal GPIO register

endmodule


 module traffic_light(c, clk, rst_n, light_farm, light_highway);
  input c;
  input clk;
  input rst_n;
  
  output reg [2:0] light_farm, light_highway;
  
  parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2, S3 = 2'd3;
  parameter RED = 3'b100, YELLOW = 3'b010, GREEN = 3'b001;
  
  reg [1:0] state, next_state;
  
  always @(posedge clk)
    if(rst_n)
      state <= S0;
  else
    state <= next_state;
  
  always @(state)
    begin
      case(state)
        S0 : begin
          light_farm = RED;
          light_highway = GREEN;
        end
        
        S1 : begin
          light_farm = RED;
          light_highway = YELLOW;
        end
        
        S2 : begin
          light_farm = GREEN;
          light_highway = RED;
        end
        
        S3 : begin
          light_farm = YELLOW;
          light_highway = RED;
        end
        
      endcase
    end
  
  always @(state or c)
    begin
      
      case(state)
        
        S0 : if(c) next_state = S1;
        else next_state = S0;
        
        S1 : begin
          #3 next_state = S1;
          next_state = S2;
        end
        
        S2 : if(c) next_state = S2;
        else next_state = S3;
        
        S3 : begin
          #3 next_state = S3;
          next_state = S0;
        end
        
        default : next_state = S0;
        
      endcase
    end
  
  
endmodule
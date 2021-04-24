class c_133_2;
    rand bit[7:0] data_8_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_8_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_8_ != 8'hbc);
    }
endclass

program p_133_2;
    c_133_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0xxz1z1x0zx0011zxz1001x0z101x10xzzzzzxxxzzzxzxzzzzxzzxzxzxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

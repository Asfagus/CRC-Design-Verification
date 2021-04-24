class c_190_2;
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

program p_190_2;
    c_190_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x0xx0z1zx0z100xxx0x1x10z01xxz1zzzxxxzzzzzxxxxzxxzxxxzzzxxxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

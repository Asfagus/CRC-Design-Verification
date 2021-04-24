class c_89_2;
    rand bit[7:0] data_5_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_5_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_5_ != 8'hbc);
    }
endclass

program p_89_2;
    c_89_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x1x0zxzxx1z000z1x0zx0x10x0z0xxxxxxxzzxzxzzzxzxxxzzzxzxzzxzzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

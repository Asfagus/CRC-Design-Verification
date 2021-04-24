class c_123_2;
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

program p_123_2;
    c_123_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0x1zx0z10100z1zzz0zzxxx1x0x000xzxzzzxzxxxxxxzxxxzxxxxxzxzxxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

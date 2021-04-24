class c_100_2;
    rand bit[7:0] data_6_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_6_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_6_ != 8'hbc);
    }
endclass

program p_100_2;
    c_100_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz1011zx0x0xz11x0x0xxz0x1z000zxzzxxxzzxxzzzzzzzzxzzzxxxxzxxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

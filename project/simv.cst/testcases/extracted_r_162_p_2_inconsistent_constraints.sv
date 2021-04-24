class c_162_2;
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

program p_162_2;
    c_162_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1x0xxzzz0x000zxzxz1110z1010zzx0zzxxxzzxxxxxxzxzxxxzzzxzzzzxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

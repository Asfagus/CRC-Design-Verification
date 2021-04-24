class c_40_2;
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

program p_40_2;
    c_40_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z111xxxxx1x0z1z11zzxxx1zz0x1zzzzzxxxzzzxzzzzxxxzxzzzzxxzxxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

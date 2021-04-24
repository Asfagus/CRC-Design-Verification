class c_181_2;
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

program p_181_2;
    c_181_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx0x1z1z1x1x0zzxz010xxz1xx0x01x1xzzzxzxxzzzxxzxzzxxzxxxxzzxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

class c_174_2;
    rand bit[7:0] data_9_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_9_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_9_ != 8'hbc);
    }
endclass

program p_174_2;
    c_174_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x1x11z1z0z0x000zz01x0z1x1z001x1zzzzxzzxxzzzzzxxzxxxxxzxzzxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

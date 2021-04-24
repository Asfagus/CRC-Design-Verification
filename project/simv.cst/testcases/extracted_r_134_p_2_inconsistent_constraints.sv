class c_134_2;
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

program p_134_2;
    c_134_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0zzxxxx1z1x0xz00z0zzxz1z11x1x11zxzxxxxzzzxxxxzxzzxxxzzxzxzxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

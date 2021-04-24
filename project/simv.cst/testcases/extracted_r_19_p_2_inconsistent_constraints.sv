class c_19_2;
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

program p_19_2;
    c_19_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z011z1z101zzz10zx1x1011zzxzxx0z0xzzxzxxzxzxxxzxzxzzxzzzxxzxxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

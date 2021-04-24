class c_46_2;
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

program p_46_2;
    c_46_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01zz10zxxzx10zzxz111xzzxxx0zxxz1zxxzxzxzzxxzzzxxzzxzzxzxzzzxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

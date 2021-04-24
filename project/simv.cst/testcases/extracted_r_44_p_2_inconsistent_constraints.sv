class c_44_2;
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

program p_44_2;
    c_44_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0zx1100z0z00zz0zz01zz0xxxz0zzz11xzxxzzxzzxzzxzxzxzxxxzxzzxxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

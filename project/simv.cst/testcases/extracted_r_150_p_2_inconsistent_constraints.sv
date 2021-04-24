class c_150_2;
    rand bit[7:0] data_7_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_7_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_7_ != 8'hbc);
    }
endclass

program p_150_2;
    c_150_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z100x0z00xzz1000zx1xxz10xx1x101zzxzxzzxxzxxzzxxzxzxzzzzxxzxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

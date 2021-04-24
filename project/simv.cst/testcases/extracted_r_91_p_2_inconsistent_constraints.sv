class c_91_2;
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

program p_91_2;
    c_91_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0zxxzzxx1zzzz00z000x1x0xxzz1z00xzxzxzzzzzzxzxzzzzxxzzxzzzxzzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

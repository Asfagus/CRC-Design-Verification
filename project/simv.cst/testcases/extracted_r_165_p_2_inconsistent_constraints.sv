class c_165_2;
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

program p_165_2;
    c_165_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11z1z101xx10011z1001z1zzz0z0110zzxzxxzzzxxzzxzzxxxzxzxxxxxxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

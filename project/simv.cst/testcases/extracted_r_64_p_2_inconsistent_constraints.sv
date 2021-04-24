class c_64_2;
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

program p_64_2;
    c_64_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "001xxx0xx0z1111001x1000zz1z11000xzxzxxxxzzzzxzxzzxxzzzzzxxzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
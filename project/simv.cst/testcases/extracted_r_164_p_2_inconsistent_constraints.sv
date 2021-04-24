class c_164_2;
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

program p_164_2;
    c_164_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0zz10xxx1000zxx0xzzz01xzz1x111xzxzxxzxzzxzzzxxxzxzxxzxxxzxzzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

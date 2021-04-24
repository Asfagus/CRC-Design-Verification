class c_92_2;
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

program p_92_2;
    c_92_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z00zz1100z01x01x10z11x0010xx0110xxzxzzzzxzxxxxxxzxzxxzxzxxxzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

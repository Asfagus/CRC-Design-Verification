class c_188_2;
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

program p_188_2;
    c_188_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1x0x0x1xz111xz00x0zx00zz0z0xxx1xzxzzzxxzxzzxxzzzxzxxxzzxxxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

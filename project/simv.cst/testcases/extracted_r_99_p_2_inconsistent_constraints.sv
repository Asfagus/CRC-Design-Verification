class c_99_2;
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

program p_99_2;
    c_99_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xx01110xz11xxzzz0z0z1zx0zz001xzzzxzzxzzzxxxzzzxzzxzzxzxxxzzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

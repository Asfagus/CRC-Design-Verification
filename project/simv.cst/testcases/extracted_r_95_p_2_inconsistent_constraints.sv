class c_95_2;
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

program p_95_2;
    c_95_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x011011zx0xxzxxz0xzxzzz0x0x1xxzzzzzzxzxzxxxzzxzxxxzxzzzzxzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

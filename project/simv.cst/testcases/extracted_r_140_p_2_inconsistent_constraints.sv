class c_140_2;
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

program p_140_2;
    c_140_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zxzz00zzzz1xzxz0z1z00z1010z0zx0xxxzxzzxxxzzzxzzzzzzxxxzzxzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

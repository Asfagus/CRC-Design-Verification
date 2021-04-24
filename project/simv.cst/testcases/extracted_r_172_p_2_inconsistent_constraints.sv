class c_172_2;
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

program p_172_2;
    c_172_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x01x1zz1zx010xzx1xxz1111x1zz0011xzzzxzxzzxxxzxxxzzzzzxxzzzxzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

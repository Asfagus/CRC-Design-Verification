class c_137_2;
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

program p_137_2;
    c_137_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1xxz00x0z0z0001zz10110zxzzx010xxxxxxzxzzzzxzxzxzxxzxzzzxzxzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

class c_117_2;
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

program p_117_2;
    c_117_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10001zxzz0x11z0x01111x11z11z0x0zxzxzxzxxzxxxzxxzxzzzzxxxxxxzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

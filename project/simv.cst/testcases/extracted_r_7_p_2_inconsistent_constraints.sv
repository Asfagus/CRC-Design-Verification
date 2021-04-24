class c_7_2;
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

program p_7_2;
    c_7_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01xzz000x0z0xzzzx0xz0010xxxz1z11zxzzzzzxzzzxzxzzzxzzzxxzzxzxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

class c_145_2;
    rand bit[7:0] data_5_; // rand_mode = ON 

    constraint c1_this    // (constraint_mode = ON) (cb_si.sv:9)
    {
       (data_5_ == 8'hbc);
    }
    constraint c3_this    // (constraint_mode = ON) (cb_si.sv:13)
    {
       (data_5_ != 8'hbc);
    }
endclass

program p_145_2;
    c_145_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0zxzz1xz1xzzxx110zz0zxz0xzxx0xzxxzzzxxzzxzzxzxxxxxxxzxzxzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

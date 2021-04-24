class c_111_2;
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

program p_111_2;
    c_111_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00xxx1x0x0011xxx1x0x101zzzxx0x01xzxzzxxxzzzzxzzzxzxzxzzzxxzxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

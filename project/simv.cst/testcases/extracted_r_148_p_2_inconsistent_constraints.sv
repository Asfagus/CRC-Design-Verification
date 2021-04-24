class c_148_2;
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

program p_148_2;
    c_148_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0zz011zxzzzxx0xx0zxz010z0x00x0zzzxxxxxxxxxzxxzzzxxzzzzxzzxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

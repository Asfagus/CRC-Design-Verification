class c_182_2;
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

program p_182_2;
    c_182_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x1101zzzzxxxz11x1101xxxz10101z1xzzxxxzxzzzxzzxxzxzzxzzxxxxxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

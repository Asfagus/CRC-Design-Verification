class c_194_2;
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

program p_194_2;
    c_194_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00xz100xx01xzz1z0z0z11xz11z0101xxzxxzzzxxzxxxzxxxxxxzzxzzzzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

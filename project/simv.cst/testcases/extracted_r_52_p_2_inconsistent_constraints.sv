class c_52_2;
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

program p_52_2;
    c_52_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x0xz1xz010xzxxz1zx1zz1zx0zz1xzzzzxzxzzzxxzxzzxxxzxzzzzzxxzzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram

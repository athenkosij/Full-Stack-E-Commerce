import { FormControl, ValidationErrors } from "@angular/forms";

export class MyOwnValidators {

    // whitespace validators
    static notOnlyWhitespace(control: FormControl) : ValidationErrors {

        // check if string only contains whitespace
        if((control.value != null) && (control.value.trim().length == 0)) {

            // invalid, return error object
            return {'notOnlyWhitespaces' : true};
        }
        else {
            // valid return null
            return null;
        }  
    }
}

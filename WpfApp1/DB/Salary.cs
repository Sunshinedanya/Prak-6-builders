//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WpfApp1.DB
{
    using System;
    using System.Collections.Generic;
    
    public partial class Salary
    {
        public int id { get; set; }
        public int EmployeeId { get; set; }
        public int ProjectId { get; set; }
        public int PerHour { get; set; }
        public int Hours { get; set; }
        public int Total { get; set; }
    
        public virtual Employee Employee { get; set; }
        public virtual Project Project { get; set; }
    }
}

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
    
    public partial class ConstructionMachinery
    {
        public int id { get; set; }
        public string name { get; set; }
        public int TypeId { get; set; }
        public Nullable<int> quantity { get; set; }
        public Nullable<int> cost { get; set; }
        public int currentProjectId { get; set; }
    
        public virtual MachineryType MachineryType { get; set; }
        public virtual Project Project { get; set; }
    }
}
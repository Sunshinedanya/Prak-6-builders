using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfApp1.DB;

namespace WpfApp1.Pages
{
    /// <summary>
    /// Логика взаимодействия для Materials.xaml
    /// </summary>
    public partial class Materials : Page
    {
        public List<ProjectEstimate> ProjectEstimates { get; set; }
        public int SelectedProjectId { get; set; }

        public Materials()
        {
            InitializeComponent();
            ProjectEstimates = DBConnector.DB.ProjectEstimate.ToList();
            DataContext = this;
            LoadProjects();
            LoadProjectEstimates();
        }

        private void LoadProjects()
        {
            var projects = DBConnector.DB.Project.ToList();
            ProjectComboBox.ItemsSource = projects;
        }

        private void ProjectComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ProjectComboBox.SelectedValue is int projectId)
            {
                SelectedProjectId = projectId;
                LoadProjectEstimates();
            }
        }

        private void LoadProjectEstimates()
        {
            var estimates = DBConnector.DB.ProjectEstimate
                                   .Where(pe => pe.ProjectId == SelectedProjectId)
                                   .ToList();

            ProjectEstimateListView.ItemsSource = estimates;
        }

        private void AddProjectEstimateButton_Click(object sender, RoutedEventArgs e)
        {
            if (SelectedProjectId == 0)
            {
                MessageBox.Show("Выберите проект перед добавлением записи.");
                return;
            }

            if (!int.TryParse(MaterialIdTextBox.Text, out int materialId) ||
                !int.TryParse(MaterialQuantityTextBox.Text, out int materialQuantity) ||
                !int.TryParse(EquipmentIdTextBox.Text, out int equipmentId) ||
                !int.TryParse(EquipmentQuantityTextBox.Text, out int equipmentQuantity))
            {
                MessageBox.Show("Проверьте корректность введённых данных.");
                return;
            }

            var newEstimate = new ProjectEstimate
            {
                ProjectId = SelectedProjectId,
                MaterialId = materialId,
                MaterialQuantity = materialQuantity,
                EquipmentId = equipmentId,
                EquipmentQuantity = equipmentQuantity
            };

            DBConnector.DB.ProjectEstimate.Add(newEstimate);
            DBConnector.DB.SaveChanges();


            LoadProjectEstimates(); // Обновить список
            ClearInputFields();
        }

        private void ClearInputFields()
        {
            MaterialIdTextBox.Clear();
            MaterialQuantityTextBox.Clear();
            EquipmentIdTextBox.Clear();
            EquipmentQuantityTextBox.Clear();
        }

        private void ShowAllEstimatesButton_Click(object sender, RoutedEventArgs e)
        {
            var allEstimates = DBConnector.DB.ProjectEstimate.ToList();
            
            ProjectEstimateListView.ItemsSource = allEstimates;
        }
    }
}

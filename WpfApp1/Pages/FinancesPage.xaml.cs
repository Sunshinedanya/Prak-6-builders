using System.Collections.Generic;
using System.Linq;
using System.Windows.Controls;
using WpfApp1.DB;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для FinancesPage.xaml
    /// </summary>
    public partial class FinancesPage : Page
    {
        public Project Project { get; set; }
        public List<ProjectEstimate> Estimates { get; set; }
        public FinancesPage()
        {
            InitializeComponent();
            LoadProjects();
        }

        private void LoadProjects()
        {
            ProjectComboBox.ItemsSource = DBConnector.DB.Project.ToList(); ;
        }

        private void LoadSalaries(int projectId)
        {
            var salaries = DBConnector.DB.Salary
                .Where(s => s.ProjectId == projectId)
                .ToList();

            SalaryListView.ItemsSource = salaries;
        }

        // Обработка выбора проекта в ComboBox
        private void ProjectComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var selectedProject = ProjectComboBox.SelectedItem as Project;

            if (selectedProject != null)
            {
                LoadProjectEstimates(selectedProject.id);
                LoadSalaries(selectedProject.id);

                // Отображаем бюджет
                BudgetTextBox.Text = selectedProject.Budget?.ToString("F2") ?? "0";

                // Пересчитываем общую стоимость и рентабельность
                CalculateTotalCost(selectedProject.Budget);
            }
            else
            {
                EstimateListView.ItemsSource = null;
                SalaryListView.ItemsSource = null;
                TotalCostTextBox.Clear();
                BudgetTextBox.Clear();
                ProfitabilityTextBox.Clear();
            }
        }


        // Загрузка Project Estimate для выбранного проекта
        private void LoadProjectEstimates(int projectId)
        {

            Estimates = DBConnector.DB.ProjectEstimate
                    .Where(pe => pe.ProjectId == projectId)
                    .ToList();

            EstimateListView.ItemsSource = Estimates;
        }

        // Расчет общей суммы стоимости материалов и оборудования
        private void CalculateTotalCost(decimal? projectBudget)
        {
            if (Estimates == null || !Estimates.Any())
            {
                TotalCostTextBox.Text = "0";
                ProfitabilityTextBox.Text = projectBudget?.ToString("F2") ?? "0";
                return;
            }

            decimal totalCost = 0;

            // Учитываем стоимость материалов и оборудования
            foreach (var estimate in Estimates)
            {
                if (estimate.Materials?.cost != null && estimate.MaterialQuantity > 0)
                {
                    totalCost += (decimal)estimate.Materials.cost * (decimal)estimate.MaterialQuantity;
                }

                if (estimate.equipment?.cost != null && estimate.EquipmentQuantity > 0)
                {
                    totalCost += (decimal)estimate.equipment.cost * (decimal)estimate.EquipmentQuantity;
                }
            }

            // Учитываем зарплаты сотрудников
            var salaries = SalaryListView.ItemsSource as IEnumerable<Salary>;
            if (salaries != null)
            {
                totalCost += salaries.Sum(s => s.Total);
            }

            // Отображаем общую стоимость
            TotalCostTextBox.Text = totalCost.ToString("F2");

            // Рассчитываем рентабельность
            if (projectBudget.HasValue)
            {
                decimal profitability = projectBudget.Value - totalCost;
                ProfitabilityTextBox.Text = profitability.ToString("F2");
            }
            else
            {
                ProfitabilityTextBox.Text = "N/A";
            }
        }
    }
}

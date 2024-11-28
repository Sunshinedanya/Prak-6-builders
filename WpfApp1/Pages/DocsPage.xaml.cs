using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using WpfApp1.DB;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для DocsPage.xaml
    /// </summary>
    public partial class DocsPage : Page
    {
        public DocsPage()
        {
            InitializeComponent();
        }

        private void AnalysisTypeComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (AnalysisTypeComboBox.SelectedItem == null) return;

            var selectedItem = (ComboBoxItem)AnalysisTypeComboBox.SelectedItem;
            string analysisType = selectedItem.Content.ToString();

            ReportGridView.Columns.Clear();

            if (analysisType == "Анализ эффективности проектов")
            {
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Проект", DisplayMemberBinding = new Binding("ProjectName"), Width = 150 });
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Бюджет", DisplayMemberBinding = new Binding("Budget"), Width = 100 });
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Общая стоимость", DisplayMemberBinding = new Binding("TotalCost"), Width = 120 });
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Рентабельность", DisplayMemberBinding = new Binding("Profitability"), Width = 120 });
            }
            else if (analysisType == "Загрузка сотрудников")
            {
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Имя", DisplayMemberBinding = new Binding("Name"), Width = 150 });
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Фамилия", DisplayMemberBinding = new Binding("Surname"), Width = 150 });
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Часы работы", DisplayMemberBinding = new Binding("WorkHours"), Width = 100 });
                ReportGridView.Columns.Add(new GridViewColumn { Header = "Проект", DisplayMemberBinding = new Binding("CurrentProjectName"), Width = 150 });
            }
        }

        private void GenerateReportButton_Click(object sender, RoutedEventArgs e)
        {
            var selectedItem = (ComboBoxItem)AnalysisTypeComboBox.SelectedItem;
            if (selectedItem == null) return;

            string analysisType = selectedItem.Content.ToString();

            if (analysisType == "Анализ эффективности проектов")
            {
                var reportData = new List<ProjectReportItem>();

                foreach (var project in DBConnector.DB.Project.ToList())
                {
                    var budget = project.Budget ?? 0;

                    // Считаем общую стоимость
                    var projectEstimates = DBConnector.DB.ProjectEstimate.Where(pe => pe.ProjectId == project.id).ToList();
                    int totalCost = 0;

                    foreach (var estimate in projectEstimates)
                    {
                        int materialCost = (int)(estimate.Materials?.cost ?? 0) * (int)estimate.MaterialQuantity;
                        int equipmentCost = (int)(estimate.equipment?.cost ?? 0) * (int)estimate.EquipmentQuantity;
                        totalCost += materialCost + equipmentCost;
                    }

                    // Учитываем зарплаты
                    var salaries = DBConnector.DB.Salary.Where(s => s.ProjectId == project.id).ToList();
                    foreach (var salary in salaries)
                    {
                        totalCost += salary.Total;
                    }

                    // Вычисляем рентабельность
                    int profitability = budget - totalCost;

                    // Добавляем данные в отчет
                    reportData.Add(new ProjectReportItem
                    {
                        ProjectName = project.name,
                        Budget = budget,
                        TotalCost = totalCost,
                        Profitability = profitability
                    });
                }

                ReportListView.ItemsSource = reportData;
            }
            else if (analysisType == "Загрузка сотрудников")
            {
                var reportData = new List<EmployeeReportItem>();

                foreach (var employee in DBConnector.DB.Employee.ToList())
                {
                    string currentProjectName = employee.Project != null ? employee.Project.name : "Нет проекта";
                    int workHours = employee.WorkHours ?? 0;

                    reportData.Add(new EmployeeReportItem
                    {
                        Name = employee.Name,
                        Surname = employee.Surname,
                        WorkHours = workHours,
                        CurrentProjectName = currentProjectName
                    });
                }

                ReportListView.ItemsSource = reportData;
            }

        }

        private void ExportButton_Click(object sender, RoutedEventArgs e)
        {
            if (ReportListView.ItemsSource == null)
            {
                MessageBox.Show("Сначала сгенерируйте отчет.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            var saveFileDialog = new Microsoft.Win32.SaveFileDialog
            {
                Filter = "Text files (*.txt)|*.txt",
                FileName = "Отчет"
            };

            if (saveFileDialog.ShowDialog() == true)
            {
                using (var writer = new StreamWriter(saveFileDialog.FileName))
                {
                    foreach (var item in ReportListView.ItemsSource)
                    {
                        writer.WriteLine(item.ToString());
                    }
                }

                MessageBox.Show("Отчет успешно экспортирован.", "Успех", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
    }

    public class ProjectReportItem
    {
        public string ProjectName { get; set; }
        public int Budget { get; set; }
        public int TotalCost { get; set; }
        public int Profitability { get; set; }
        public override string ToString()
        {
            return $"Проект: {ProjectName}, Бюджет: {Budget}, Общая стоимость: {TotalCost}, Рентабельность: {Profitability}";
        }
    }

    public class EmployeeReportItem
    {
        public string Name { get; set; }
        public string Surname { get; set; }
        public int WorkHours { get; set; }
        public string CurrentProjectName { get; set; }
        public override string ToString()
        {
            return $"Сотрудник: {Name} {Surname}, Часы работы: {WorkHours}, Текущий проект: {CurrentProjectName}";
        }
    }
}

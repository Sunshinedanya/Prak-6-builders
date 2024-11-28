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
    /// Логика взаимодействия для Machinery.xaml
    /// </summary>
    public partial class Machinery : Page
    {
        public List<ConstructionMachinery> MachineryList { get; set; }
        public int SelectedProjectId { get; set; }
        public ConstructionMachinery SelectedMachinery { get; set; }

        public Machinery()
        {
            InitializeComponent();
            MachineryList = DBConnector.DB.ConstructionMachinery.ToList();
            DataContext = this;
            LoadProjects();
        }

        // Метод для загрузки списка проектов в ComboBox
        private void LoadProjects()
        {
            var projects = DBConnector.DB.Project.ToList();
            ProjectComboBox.ItemsSource = projects;
            NewProjectComboBox.ItemsSource = projects;
        }

        private void ProjectComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (ProjectComboBox.SelectedValue is int projectId)
            {
                SelectedProjectId = projectId;
                LoadMachineryForProject();
            }
        }

        private void LoadMachineryForProject()
        {
            var machinery = DBConnector.DB.ConstructionMachinery
                                   .Where(m => m.currentProjectId == SelectedProjectId)
                                   .ToList();

            MachineryList.Clear();
            foreach (var item in machinery)
            {
                MachineryList.Add(item);
            }
        }

        private void MachineryListView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            SelectedMachinery = MachineryListView.SelectedItem as ConstructionMachinery;

            if (SelectedMachinery != null)
            {
                NameTextBox.Text = SelectedMachinery.name;
                TypeTextBox.Text = SelectedMachinery.MachineryType?.name ?? "Не указан";
                QuantityTextBox.Text = SelectedMachinery.quantity?.ToString() ?? "0";
                CostTextBox.Text = SelectedMachinery.cost?.ToString() ?? "0";
            }
        }
        private void TransferMachineryButton_Click(object sender, RoutedEventArgs e)
        {
            if (SelectedMachinery == null || NewProjectComboBox.SelectedValue == null)
            {
                MessageBox.Show("Выберите технику и проект для переноса.");
                return;
            }

            int newProjectId = (int)NewProjectComboBox.SelectedValue;

            var machinery = DBConnector.DB.ConstructionMachinery.Find(SelectedMachinery.id);
            if (machinery != null)
            {
                machinery.currentProjectId = newProjectId;
                DBConnector.DB.SaveChanges();
            }

            LoadMachineryForProject(); // Обновляем список техники для текущего проекта
        }
    }
}

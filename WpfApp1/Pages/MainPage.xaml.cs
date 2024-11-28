﻿using System;
using System.Collections.Generic;
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
using WpfApp1.Pages;

namespace WpfApp1
{
    /// <summary>
    /// Логика взаимодействия для Page1.xaml
    /// </summary>
    public partial class MainPage : Page
    {
        public MainPage()
        {
            InitializeComponent();
        }

        private void Projects(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ProjectsPage());
        }

        private void Logistics(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new LogisticsPage());
        }

        private void Finance(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new FinancesPage());
        }

        private void Documents(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new DocsPage());
        }

        private void Deadlines(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new DeadlinesPage());
        }

        private void Machinery(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Machinery());
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new Materials());
        }
    }
}
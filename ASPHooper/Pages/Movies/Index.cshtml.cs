﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using ASPHooper.Data;
using ASPHooper.Models;

namespace ASPHooper.Pages.Movies
{
    public class IndexModel : PageModel
    {
        private readonly ASPHooper.Data.ApplicationDbContext _context;

        public IndexModel(ASPHooper.Data.ApplicationDbContext context)
        {
            _context = context;
        }

        public IList<Movie> Movie { get;set; } = default!;

        public async Task OnGetAsync()
        {
            if (_context.Movie != null)
            {
                Movie = await _context.Movie.ToListAsync();
            }
        }
    }
}
